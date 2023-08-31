import { ss } from '@/utils/storage'

const LOCAL_NAME = 'settingsStorage'
const CURRENT_VERSION = 1; // Update this whenever you change the default settings

export interface SettingsState {
  version: number
  systemMessage: string
  temperature: number
  top_p: number
}

export function defaultSetting(): SettingsState {
  return {
    version: CURRENT_VERSION,
    systemMessage: '',
    temperature: 0.8,
    top_p: 1,
  }
}

export function getLocalState(): SettingsState {
  const localSetting: SettingsState | undefined = ss.get(LOCAL_NAME)
  const defaultSettings = defaultSetting();
  
  if (!localSetting || localSetting.version !== defaultSettings.version) {
    // If there is no local setting, or the version of the local setting is not the current version,
    // overwrite the local setting with the default settings
    setLocalState(defaultSettings);
    return defaultSettings;
  }
  
  return { ...defaultSettings, ...localSetting }
}

export function setLocalState(setting: SettingsState): void {
  ss.set(LOCAL_NAME, setting)
}

export function removeLocalState() {
  ss.remove(LOCAL_NAME)
}
